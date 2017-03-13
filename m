From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 13 Mar 2017 18:08:55 -0500
Subject: [PATCH V4 0/3] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
In-Reply-To: <c6b78903-ea09-9719-7073-c679b0b64a05@codeaurora.org>
References: <1489438085-2055-1-git-send-email-okaya@codeaurora.org>
 <20170313214616.GE8232@bhelgaas-glaptop.roam.corp.google.com>
 <c6b78903-ea09-9719-7073-c679b0b64a05@codeaurora.org>
Message-ID: <20170313230855.GG8232@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 06:05:55PM -0400, Sinan Kaya wrote:
> On 3/13/2017 5:46 PM, Bjorn Helgaas wrote:
> > What is this series based on?  Unless they depend on other in-flight
> > patches, I apply patches to branches based on my "master" branch,
> > which is typically -rc1 or -rc2 (it's currently v4.11-rc1).  These
> > don't apply to either.
> 
> It looks like I am on 4.10. I can rebase and post again. 

Rebasing would be good, but I can give you some comments on your v4,
now that I can apply it and see what it looks like.
