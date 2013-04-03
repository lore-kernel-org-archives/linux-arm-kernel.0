From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 03 Apr 2013 18:11:57 +0100
Subject: [PATCH 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <CAHTX3dJMpp+E2u-cAeYbqtxC1WAYWpCeRx6W7G=dWDcgzUz5DA@mail.gmail.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-4-git-send-email-michal.simek@xilinx.com>
 <515059D4.5070903@gmail.com>
 <CAHTX3dJfvFNNuyJC54fS=NCpRxovVsxHTss8wJd_QOB2PaxL7g@mail.gmail.com>
 <51506F31.2080709@gmail.com>
 <CAHTX3d+1auKVLko+LKAA+a4rh4Rfw19ggzmS7DhvYuuCAWUwHA@mail.gmail.com>
 <1364920809.3019.30.camel@hornet>
 <CAHTX3dKD4G0E8qoxTR2HnJVdagoeOerM+TiZzkJUPjcGwYdX_Q@mail.gmail.com>
 <1365005177.26858.11.camel@hornet>
 <CAHTX3dJMpp+E2u-cAeYbqtxC1WAYWpCeRx6W7G=dWDcgzUz5DA@mail.gmail.com>
Message-ID: <1365009117.26858.14.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-03 at 18:04 +0100, Michal Simek wrote:
> Then my question is if you can just remove that ioremap, as I have
> done for zynq,
> without any related problem.

Well, the vexpress platsmp functions are going away soon, replaced by
the generic DT code. When this happen I won't even try to access the
SCU, so both its static mapping and the ioremap will go as well :-)

Pawe?
