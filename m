From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 5 Nov 2017 08:21:41 +0100
Subject: [PATCH v3] tty: serial: meson: allow baud-rates lower than 9600
In-Reply-To: <bef0434b-fa23-464e-8c6c-d1f7dc678767@myway.de>
References: <19343ad6-75de-4059-825a-98ed40ecf423@myway.de>
 <20171104131352.GA9271@kroah.com>
 <bef0434b-fa23-464e-8c6c-d1f7dc678767@myway.de>
Message-ID: <20171105072141.GC28366@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 05, 2017 at 05:26:59AM +0100, V10lator wrote:
> Am Samstag, 4. November 2017 14:13:52 CET schrieb Greg Kroah-Hartman:
> > What changed from v2?
> 
> Nothing. I just re-based the patch on a fresh git clone as you couldn't
> merge v2.

Then you need to say so somewhere otherwise I, and everyone else, has no
idea what changed.

Remember, I get thousands of patches a week to review, and have the
short-term memory of a squirrel :(

thanks,

greg k-h
