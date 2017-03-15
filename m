From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 15 Mar 2017 12:52:08 +0800
Subject: [PATCH] vc04_services: Fixing coding and logical guidelines
In-Reply-To: <1489496944-44038-1-git-send-email-pushkar.iit@gmail.com>
References: <1489496944-44038-1-git-send-email-pushkar.iit@gmail.com>
Message-ID: <20170315045208.GA9748@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 06:39:04PM +0530, Pushkar Jambhlekar wrote:
> Description:

No need for that line.

>     in file 'vc04_services/interface/vchiq_arm/vchiq_shim.c', making changes to make code according to 'checkpath.pl'.

Why indent?  Also, you need to be specific as to what type of changes
you made.

> Also, fixing logical issue, i.e. removing break after goto statement.

Don't do multiple things in the same patch, break it up into
one-patch-per-thing, and no, "checkpatch.pl cleanups" is not "one
thing" :)

thanks,

greg k-h
