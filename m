From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 16 Jan 2015 16:44:40 +0100
Subject: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <54B8E904.6090107@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk> <54B8E904.6090107@samsung.com>
Message-ID: <1421423080.2450.229.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-01-16 at 11:33 +0100, Marek Szyprowski wrote:
> Hello,
> 
> On 2014-12-02 10:59, Sjoerd Simons wrote:
> > Hey Marek, Inki,
> >
> > On Wed, 2014-11-19 at 12:15 +0100, Marek Szyprowski wrote:
> >> Hello Everyone,
> >>
> >> This is another attempt to finally make Exynos SYSMMU driver fully
> >> integrated with DMA-mapping subsystem. The main change from previous
> >> version is a rebase onto latest "automatic DMA configuration for IOMMU
> >> masters" patches from Will Deacon.
> > Do you happen to know if anyone is working on iommu/dma-mapping patches
> > for Exynos 5 based on this patchset?
> 
> Just to let all of You know - I posted a new version of this patchset with
> Exynos 5250 & 5420/5422/5800 DTS patches:
> 
> http://lists.linaro.org/pipermail/linaro-mm-sig/2015-January/004327.html

Great thanks!. As there are quite a few dependencies, do you happen to
have a public git tree with the combined work in ? Would make testing a
lot simpler.

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/fb6a2234/attachment-0001.bin>
