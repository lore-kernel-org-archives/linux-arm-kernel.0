From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Oct 2015 10:54:38 +0200
Subject: [PATCH 11/13] ARM: sun7i: Enable cubieboard2 audio codec
In-Reply-To: <CAGb2v64yEAeZSthTYNmZ+HR=W3FmLoELnVsj=VpCxKUt73gt7Q@mail.gmail.com>
References: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
 <1445460786-18280-12-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64yEAeZSthTYNmZ+HR=W3FmLoELnVsj=VpCxKUt73gt7Q@mail.gmail.com>
Message-ID: <20151022085438.GS10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 12:27:23PM +0800, Chen-Yu Tsai wrote:
> On Thu, Oct 22, 2015 at 4:53 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The cubieboard uses the internal codec to output sound to its mini-jack.
> 
>       ^^^^^^^^^^
> 
> May want to change this to Cubieboard2?

Right, I've applied all your patches with your Acked-by, and fixed
both this and the other error you found in the commit log.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/959a05c6/attachment.sig>
