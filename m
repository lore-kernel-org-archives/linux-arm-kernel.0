From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 19 Mar 2017 14:25:01 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170317114203.GZ21222@n2100.armlinux.org.uk>
References: <c679f755-52a6-3c6f-3d65-277db46676cc@xs4all.nl>
 <20170310140124.GV21222@n2100.armlinux.org.uk>
 <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
 <20170313124621.GA10701@valkosipuli.retiisi.org.uk>
 <20170314004533.3b3cd44b@vento.lan>
 <e0a6c60b-1735-de0b-21f4-d8c3f4b3f10f@xs4all.nl>
 <20170317114203.GZ21222@n2100.armlinux.org.uk>
Message-ID: <20170319132501.GA25673@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2017-03-17 11:42:03, Russell King - ARM Linux wrote:
> On Tue, Mar 14, 2017 at 08:55:36AM +0100, Hans Verkuil wrote:
> > We're all very driver-development-driven, and userspace gets very little
> > attention in general. So before just throwing in the towel we should take
> > a good look at the reasons why there has been little or no development: is
> > it because of fundamental design defects, or because nobody paid attention
> > to it?
> > 
> > I strongly suspect it is the latter.
> > 
> > In addition, I suspect end-users of these complex devices don't really care
> > about a plugin: they want full control and won't typically use generic
> > applications. If they would need support for that, we'd have seen much more
> > interest. The main reason for having a plugin is to simplify testing and
> > if this is going to be used on cheap hobbyist devkits.
> 
> I think you're looking at it with a programmers hat on, not a users hat.
> 
> Are you really telling me that requiring users to 'su' to root, and then
> use media-ctl to manually configure the capture device is what most
> users "want" ?

If you want to help users, right way is to improve userland support. 

> Hasn't the way technology has moved towards graphical interfaces,
> particularly smart phones, taught us that the vast majority of users
> want is intuitive, easy to use interfaces, and not the command line
> with reams of documentation?

How is it relevant to _kernel_ interfaces?
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170319/1fdadf3e/attachment-0001.sig>
