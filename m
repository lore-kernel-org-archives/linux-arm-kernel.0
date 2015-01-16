From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Jan 2015 19:44:00 +0000
Subject: [PATCH v4 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the
 SATA port
In-Reply-To: <54B962E0.9060504@redhat.com>
References: <1421330978-9694-1-git-send-email-gregory.clement@free-electrons.com>
 <1421330978-9694-5-git-send-email-gregory.clement@free-electrons.com>
 <54B8C933.7020502@redhat.com> <54B8D97B.3090908@free-electrons.com>
 <54B8E38A.6020709@redhat.com> <20150116123705.GM3043@sirena.org.uk>
 <54B91FB4.5080707@free-electrons.com>
 <20150116153451.GA3856@sirena.org.uk> <54B962E0.9060504@redhat.com>
Message-ID: <20150116194400.GK3856@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 08:13:36PM +0100, Hans de Goede wrote:
> On 16-01-15 16:34, Mark Brown wrote:

> >>As pointed by Hans my concern here was be sure that during boot the disk
> >>are not power off. In this case which property would be accurate?

> >None, the core won't do anything with the regulator until the end of
> >init anyway.

> That us simply not true, see my other mail gpio enabled regulators will
> be turned off *at register time* unless they have regulator-boot-on set.

That's not the core, that's the specific driver (which I didn't know
this board happened to be using).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/8761a950/attachment.sig>
