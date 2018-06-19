From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 19 Jun 2018 16:59:55 -0500
Subject: [PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
In-Reply-To: <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
References: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
 <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
 <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
Message-ID: <20180619215955.GF33049@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 10:20:29AM -0400, Sinan Kaya wrote:
> On 5/18/2018 6:42 AM, Robin Murphy wrote:
> > 
> > FWIW, now that I've actually gone and looked, it appears you could simplify the whole function quite a bit by getting rid of these and just using the new local resource directly, especially since the only actual use of size is an open-coded resource_contains().
> 
> Posted V2 a minute ago. I did the simplification on a prior patch in order not to
> mix the issues.

I don't see the V2 on linux-pci, but it sounds like Ard would merge this
anyway.  So I'll drop this and you can let me know if there's anything you
need from me.
