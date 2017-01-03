From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 03 Jan 2017 22:54:19 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <3286019.I2UkVCJq41@wuerfel>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
 <20170103152436.GA26156@kroah.com> <3286019.I2UkVCJq41@wuerfel>
Message-ID: <1483480459.10534.8.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-01-03 at 22:19 +0100, Arnd Bergmann wrote:
> Sounds good to me. My original series contained four more patches that
> I did not post again after there was some concern[1] that we did not
> come to a conclusion on:
> 
> isdn: gigaset: remove i4l code

Let me repeat that I'm fine with a patch that does that.

> isdn: move isdnhdlc out of i4l
> isdn: i4l: move hisax driver to staging
> isdn: move i4l to staging
> 
> I can post those as well, at least I think the first two are helpful
> for untangling i4l from the rest of ISDN.  I also still think that
> moving hisax and i4l to staging is reasonable given the state of
> that code, even if there are a couple of users today.

There are? And even if there are: is there any reason to expect that moving
the rest of i4l to staging will result in anything other than a stream of
checkpatch cleanups?

How often did a bunch of drivers re-enter the tree after being sent to
staging?


Paul Bolle
