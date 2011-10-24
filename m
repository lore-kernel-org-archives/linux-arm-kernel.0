From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Oct 2011 10:29:27 +0100
Subject: [RFC PATCH 13/15] ARM: uncompress.h: Cleanup header guards and
	banners
In-Reply-To: <1319404245-12740-13-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
	<1319404245-12740-13-git-send-email-zoss@devai.org>
Message-ID: <20111024092927.GF9893@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 11:10:43PM +0200, Zoltan Devai wrote:
> Bring some standard into the files:
> - uncompress.h should only be included once, don't hide an
>   error with the header guards
> - If the copyright banner is longer than the real content,
>   or the file has been mostly rewritten, just stick
>   a short-form GPl notice on top

This changes the license terms on these files, some of them are GPL2+
and you're changing them to be GPL2.  You don't have the right to make
that change.
