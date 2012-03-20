From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 20 Mar 2012 12:57:55 +0000
Subject: [PATCH v5 2/3] arm:davinci: move emif driver to mfd framework
In-Reply-To: <20120316172908.GG20524@sortiz-mobl>
References: <y> <1330005504-25321-3-git-send-email-prakash.pm@ti.com>
 <20120227142638.GN27687@sortiz-mobl>
 <A73F36158E33644199EB82C5EC81C7BC3176D103@DBDE01.ent.ti.com>
 <20120301112329.GI9008@sortiz-mobl>
 <A73F36158E33644199EB82C5EC81C7BC317702E9@DBDE01.ent.ti.com>
 <20120316172908.GG20524@sortiz-mobl>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3178627F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Fri, Mar 16, 2012 at 22:59:08, Samuel Ortiz wrote:
> Hi Prakash,
> 
> On Tue, Mar 06, 2012 at 01:12:25PM +0000, Manjunathappa, Prakash wrote:
> > Hi Samuel,
> > 
> > May be I did not do a good job giving complete information on this earlier.
> > So I have replied on top of my mail with below information (seems you missed it)
> > 
> I did get it, sorry for not being able to reply earlier.
> 
> 
> > Taking above points into consideration Arnd Bergmann suggested to move AEMIF driver to
> > MFD framework [1], relevant portion of his mail as follows,
> > 
> > " If you want it to provide endpoint devices that are handled by
> > distinct subsystems in Linux, I would make it an mfd multifunction
> > device and make the common... "
> You're missing that part of the quote:
> 
> "...code a driver that scans the connected memories in order to register
> its child devices for each of the subsystems."
> 

emif is not discoverable interface, does not support scanning for connected devices.

Could you please let me know if there is any other way to achieve this? I will be happy
to incorporate that and submit next version of the patch.

Thanks,
Prakash
