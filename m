From: tj@kernel.org (Tejun Heo)
Date: Tue, 14 Jan 2014 11:46:14 -0500
Subject: [PATCH v8 3/4] ata: Add APM X-Gene SoC SATA host controller driver
In-Reply-To: <CAPw-ZTn7QZkPGLMYkd0m4uS_vC53bOfv-N7M=jUTnzMSVJkMrw@mail.gmail.com>
References: <6EB44142-06DA-4C9D-8999-CFA9EE30E03D@apm.com>
 <20140112114958.GA8509@mtj.dyndns.org>
 <CAPw-ZTmfKfPY3DRfJT6FQP78ULwfcjGG76cNfr9yk7UMdrO4wg@mail.gmail.com>
 <20140113160843.GB29053@htj.dyndns.org>
 <CAPw-ZT=A=c9-3BfP-LoDBXByQqfvATpAdS4NPPWB9+R1+GHfDA@mail.gmail.com>
 <20140114160312.GH12131@htj.dyndns.org>
 <20140114160419.GI12131@htj.dyndns.org>
 <CAPw-ZTmn6JiDku=vz=m9v5MNuFrK_-d0ehU_88drCYGHM8Wv=Q@mail.gmail.com>
 <20140114163008.GJ12131@htj.dyndns.org>
 <CAPw-ZTn7QZkPGLMYkd0m4uS_vC53bOfv-N7M=jUTnzMSVJkMrw@mail.gmail.com>
Message-ID: <20140114164540.GK12131@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 08:37:18AM -0800, Loc Ho wrote:
> This issue has NOT been observed but the design has this issue and
> observed from verification. As a mean to ensure that this never occur
> from design itself, this is the workaround and only apply to SATA and
> SDIO. The SDIO don't need this special flush as discussed in earlier
> email.

Urgh... can't say I'm a big fan of this hardware. :(

-- 
tejun
