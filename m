From: sam@ravnborg.org (Sam Ravnborg)
Date: Thu, 29 Oct 2009 10:44:51 +0100
Subject: Query : head.S assembler options
In-Reply-To: <d06872620910290011u6d724437s991a3de94a660e60@mail.gmail.com>
References: <d06872620910290011u6d724437s991a3de94a660e60@mail.gmail.com>
Message-ID: <20091029094451.GA20948@merkur.ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2009 at 12:41:26PM +0530, ??????????????? ??????????????? ??????????????? wrote:
> I want to see the assembler options for : arch/arm/kernel/head.S.
> I want to confirm if it has __ASSEMBLY__ being passed to it.

make V=1 arch/arm/kernel/head.o should tell you
the specific options used.

	Sam
