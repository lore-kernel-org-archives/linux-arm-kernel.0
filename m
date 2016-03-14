From: luto@amacapital.net (Andy Lutomirski)
Date: Sun, 13 Mar 2016 17:39:42 -0700
Subject: [PATCH] kbuild: drop FORCE from PHONY targets
In-Reply-To: <1457828035-30584-1-git-send-email-yamada.masahiro@socionext.com>
References: <1457828035-30584-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CALCETrVqzidL7SXsCVm8wWrcQMR9dFOLGnDtC-eEYMO4a+yszA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 12, 2016 4:14 PM, "Masahiro Yamada"
<yamada.masahiro@socionext.com> wrote:
>
> These targets are marked as PHONY.  No need to add FORCE to their
> dependency.

If this is, in fact, correct, can you update
Documentation/kbuild/makefiles.txt as well?

Thanks,
Andy
