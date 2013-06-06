From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Thu, 06 Jun 2013 02:23:44 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDwrpoYCFuWJvF99Yua_TBoONeEH8UkTZvC7dTev6FAYfw@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <CAPweEDzDC87KmOQ=0hyPcjPtPsRuXHxNTs97vbEqVNNnix69rA@mail.gmail.com>
 <1370468873.18839.22.camel@localhost>
 <CAPweEDwrpoYCFuWJvF99Yua_TBoONeEH8UkTZvC7dTev6FAYfw@mail.gmail.com>
Message-ID: <1370478224.20454.69.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ons 2013-06-05 klockan 23:20 +0100 skrev luke.leighton:

>  ok: great.  so we have something that i can potentially propose to
> them.   now: what reason can i give that they should accept this?
> what's the biggest incentive for them, here, to make these changes?
> what would they gain?

Mainly a common infrastructure so they don't need to hack every driver
to work with their scheme.

But there is no way to escape from the fact that first round will be far
more complicated than just adding their own stuff as-is likely is. Many
of the upstreamed drivers are rewritten and far from their drivers.

And further complicated by their supported designs often using devices
(wifi modules, touch panels, nand chips, etc) where 3 year old barely
maintained vendor code actually works better than what is currently in
the upstream kernel. 

So no, I can not say that there is an easy road ahead,

Regards
Henri
