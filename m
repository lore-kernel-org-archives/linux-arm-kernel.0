From: rreedd555@gmail.com (takanobu watanabe)
Date: Tue, 10 Aug 2010 16:59:15 +0900
Subject: kernel2.6.34.1 headers_install did not make asm
In-Reply-To: <1281426861.7143.60.camel@localhost>
References: <AANLkTi=E9nYU8nV2LiaaS2tENYThqb42rasDoohMKaC=@mail.gmail.com>
	<1281426861.7143.60.camel@localhost>
Message-ID: <AANLkTi=AgeOPhhJRDiQ7S6dBywn0hYyyZGCVqScVBTV-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Woodhouse,

Thank you very much!

On 10 August 2010 16:54, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2010-08-10 at 16:50 +0900, takanobu watanabe wrote:
>>
>> tknv at Lenny55G:~/src/kernel-2.6.34/linux-2.6.34.1$ ls include/
>> acpi ? ? ? ? crypto ? ? Kbuild ?math-emu ?net ? ? rxrpc ?trace
>> asm-generic ?drm ? ? ? ?keys ? ?media ? ? pcmcia ?scsi ? video
>> config ? ? ? generated ?linux ? mtd ? ? ? rdma ? ?sound ?xen
>
> ls usr/include/
>
> Or use 'make INSTALL_HDR_PATH=/somewhere/else' if you want to put the
> resulting headers elsewhere.
>
> --
> David Woodhouse ? ? ? ? ? ? ? ? ? ? ? ? ? ?Open Source Technology Centre
> David.Woodhouse at intel.com ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Intel Corporation
>
>



-- 
tknv/
