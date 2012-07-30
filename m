From: greg@kroah.com (Greg KH)
Date: Mon, 30 Jul 2012 09:01:46 -0700
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <20120730160146.GB28703@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 09:50:57AM +0000, Singh Sandeep-B37400 wrote:
> 1. You should send some kernel mode TDM clients. Without those the framework
>    is pretty useless.
> [Sandeep] We do have a test client but not good enough to be pushed in
> open source, should we add it to documentation?? 

Then how do you know if the framework is "correct" and good enough for
real clients?  We don't add frameworks, or apis, to the kernel without
users, so you will have to come up with some users before we can accept
it.

greg k-h
