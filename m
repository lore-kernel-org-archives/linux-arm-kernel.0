From: wei.liu2@citrix.com (Wei Liu)
Date: Fri, 8 Aug 2014 17:12:33 +0100
Subject: [PATCH v3 2/3] xen/arm: reimplement xen_dma_unmap_page & friends
In-Reply-To: <CAG4opy8T1kqfofbbNfAOmynAniwfpS+PktK1t3ZNMo17j4BZ5w@mail.gmail.com>
References: <alpine.DEB.2.02.1408011552460.2293@kaball.uk.xensource.com>
 <1406904984-16068-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1408081530580.2293@kaball.uk.xensource.com>
 <20140808143851.GF29341@zion.uk.xensource.com>
 <CAG4opy9ChMRYFkMz+RHqacGO3=d+mS=6ZS2qMALHpPUDzhSYsQ@mail.gmail.com>
 <20140808150001.GG29341@zion.uk.xensource.com>
 <CAG4opy8T1kqfofbbNfAOmynAniwfpS+PktK1t3ZNMo17j4BZ5w@mail.gmail.com>
Message-ID: <20140808161233.GJ29341@zion.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 05:01:42PM +0100, Thomas Leonard wrote:
[...]
> OK, that works for me! I tried starting the quickly-exiting VM a few
> times and it didn't break anything, and my queue service served up the
> file too. Thanks!
> 
> (for reference, this is the exact commit I tested:
> https://github.com/talex5/linux/commit/026c61c9649e0ef30546222a429a1b11ae7a7555)
> 

Thanks for testing.

I will submit my network driver patches shortly.

Wei.
