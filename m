From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Oct 2011 10:30:44 +0100
Subject: [RFC PATCH 14/15] ARM: uncompress: Get decompress UART info
	from DT
In-Reply-To: <1319404245-12740-14-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
	<1319404245-12740-14-git-send-email-zoss@devai.org>
Message-ID: <20111024093044.GG9893@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 11:10:44PM +0200, Zoltan Devai wrote:
> Allow the static decompress UART setup in uncompress.h
> files to be overridden with an ucuart description in DT.
> 
> At a later stage, this may also allow to skip the
> inclusion of uncompress.h files on arches which are DT-only,
> to get rid of these files completely.

This needs to be reviewed by DT people.
