From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 15 Feb 2015 17:27:03 +0100
Subject: n900 audio: any ideas how to get headset speaker to work?
In-Reply-To: <20150215162028.GA6857@amd>
References: <20150215102152.GA23736@amd> <201502151208.03126@pali>
 <20150215162028.GA6857@amd>
Message-ID: <201502151727.03129@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 February 2015 17:20:29 Pavel Machek wrote:
> On Sun 2015-02-15 12:08:02, Pali Roh?r wrote:
> > On Sunday 15 February 2015 11:21:52 Pavel Machek wrote:
> > > Hi!
> > > 
> > > By default, output goes to loudspeaker (top right relative
> > > to keyboard). Any ideas how to switch it to the speaker
> > > on the left or wired headset? Because I suspect that echo
> > > cancelation is not going to be simple...
> > > 
> > > 									Pavel
> > 
> > I do not know but maybe this file could help:
> > 
> > https://gitorious.org/community-ssu/policy-settings-rx51/sou
> > rce/dcb6429c12006dc9850cc942b7143358fe3fd330:rx51/etc/alsape
> > d.conf
> > 
> > There are definitions of alsa channels and settings for
> > different profiles.
> 
> Thanks... it seems to be what I needed. More code to write...
> 									Pavel

Will you create asoundrc file with both speakers for n900?

I would like to see n900 sound setup without pulseaudio...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150215/da5d411f/attachment.sig>
