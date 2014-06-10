From: Peter.Chen@freescale.com (Peter Chen)
Date: Tue, 10 Jun 2014 01:16:18 +0000
Subject: [PATCH 0/9] ARM: Berlin: USB support
In-Reply-To: <53958913.8080708@gmail.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140609043019.GA32255@shlinux1.ap.freescale.net>
 <53958913.8080708@gmail.com>
Message-ID: <63fc1fa8280b498182ebf8a3654732b9@BL2PR03MB226.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> we are early in the cycle and I feel there will be a v2 of the chipidea
> stub. IMHO, controlling the vbus regulator should not be business of the
> phy driver, so ci will have to deal with it.
> 

vbus handling has already in chipidea common code, it treats vbus as a regulator.
So, the glue layer only needs to register and add vbus-supply to dts file, no source
code change is needed.

Peter

> Anyways, good to know you are fine with it already!
> 
> Sebastian
