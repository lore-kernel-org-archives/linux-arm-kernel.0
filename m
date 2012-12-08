From: rtivy@ti.com (Tivy, Robert)
Date: Sat, 8 Dec 2012 01:04:09 +0000
Subject: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
 OMAP-L138 DSP
In-Reply-To: <50C1A7B7.1020502@ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-5-git-send-email-rtivy@ti.com> <50AB76FA.1050505@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F952B@DFLE08.ent.ti.com>
 <50B88F7C.5000705@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FAC29@DFLE08.ent.ti.com>
 <50BCBA26.4070608@ti.com> <50BD07D8.5000305@ti.com>
 <50BD90F6.4080102@ti.com> <50BE0E54.5060607@ti.com>
 <50BE2115.4000606@ti.com> <50C1A7B7.1020502@ti.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C14311FBA17@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Nori, Sekhar
> Sent: Friday, December 07, 2012 12:24 AM
> On 12/4/2012 9:43 PM, Murali Karicheri wrote:
> > On 12/04/2012 09:53 AM, Murali Karicheri wrote:
> >> I believe this is addressing the same issue. This is a DT based
> >> solution, which I believe should add a framework and enhance it to
> >> support DT.
> > Forgot to paste the link. Here we go
> >
> > https://patchwork.kernel.org/patch/1635051/
> 
> Rob,
> 
> Since there is a solution for reset handling proposed but seems to be
> slightly far from taking a concrete shape, I suggest you go ahead and
> implement davinci reset using a platform private API ala Tegra.
> 
> You can create and send the patches. I will review and accept them but
> not send them upstream immediately.
> 
> Lets wait till v3.8-rc4. If there is a generic solution that is merged
> by that time, I will ask you to use that instead of your API (this will
> give you about 2 weeks to convert). If the generic solution is not
> merged by that time, I will send your private API to the upstreams for
> v3.9 and we can convert to generic solution for later kernel versions.
> 
> This should give you a fair chance to get remoteproc working on DA850
> for v3.9.
> 
> Sounds like a plan? The remoteproc folks need to agree too. I am
> copying
> Ohad here.

I'm on board with that plan, thanks very much for the suggestion, I agree completely.

> 
> Meanwhile I do suggest you work with Stephen and Mike in giving shape
> to
> the reset API so it suits your needs when it gets ready.

Will do.

Thanks & Regards,

- Rob

> 
> Thanks,
> Sekhar
