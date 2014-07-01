From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 1 Jul 2014 09:59:58 +0200
Subject: [PATCH 6/9] ARM: dts: sun7i: Add board support for LinkSprite
 pcDuino V3
In-Reply-To: <53B2638A.3060206@redhat.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
 <1404165479-23785-7-git-send-email-hdegoede@redhat.com>
 <CAGb2v65mDnuwveUiTKU2J3b3jbNzRLvPjS+wXNEj2MRtDN4Q2w@mail.gmail.com>
 <53B25F60.2050704@redhat.com>
 <CAGb2v64KMxXQ7QaRcsWxHbCLNJtWkh5sxj82C-y9GyNW7R+M_Q@mail.gmail.com>
 <53B2638A.3060206@redhat.com>
Message-ID: <20140701075958.GJ28647@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 09:30:18AM +0200, Hans de Goede wrote:
> Ok, I'm not seeing anything for 3.17 here though:
> https://github.com/mripard/linux/
> 
> Maxime, can you push a sunxi/dt-for-3.17 with what you currently have there?

Ah, sorry, my bad.

>From 3.17, I started to use a kernel.org git tree there:

git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git

And forgot to notify you.

There will also be linux-next coverage for the patches I gather.

> Then I'll rebase this series on top, fix the commit msg thingie Chen
> pointed out and send a v2.

Fixed the whitespace error, the conflict, and the commit message, and
applied.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140701/e2e50297/attachment.sig>
