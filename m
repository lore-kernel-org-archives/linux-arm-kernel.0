From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 26 Jun 2017 13:16:21 +0200
Subject: omap3isp camera was Re: [PATCH v1 0/6] Add support of OV9655
 camera
In-Reply-To: <5364AD62-5000-451E-B3F7-93D49A91EED5@goldelico.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <385A82AC-CC23-41BD-9F57-0232F713FED9@goldelico.com>
 <1E453955-0C1A-414B-BBB2-C64B6D0EF378@goldelico.com>
 <20170625091856.GA22791@amd>
 <EDFD663F-37F9-42C2-92A9-66C2508B361E@goldelico.com>
 <20170626083927.GB9621@amd>
 <5364AD62-5000-451E-B3F7-93D49A91EED5@goldelico.com>
Message-ID: <20170626111621.GC11688@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > You may want to try this one:
> > 
> > commit 0eae9d2a8f096f703cbc8f9a0ab155cd3cc14cef
> > Author: Pavel <pavel@ucw.cz>
> > Date:   Mon Feb 13 21:26:51 2017 +0100
> > 
> >    omap3isp: fix VP2SDR bit so capture (not preview) works
> > 
> >    This is neccessary for capture (not preview) to work properly on
> >        N900. Why is unknown.
> 
> Ah, interesting. I will give it a try.
> 
> Do you please have a link to the repo where this commit can be
> > found?

This branch, as mentioned before:

https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-n900.git/log/?h=camera-fw5-6

									Pavel
									

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170626/2dd6db38/attachment.sig>
