From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 14 Mar 2016 13:08:16 +0900
Subject: [PATCH] kbuild: drop FORCE from PHONY targets
In-Reply-To: <CALCETrVqzidL7SXsCVm8wWrcQMR9dFOLGnDtC-eEYMO4a+yszA@mail.gmail.com>
References: <1457828035-30584-1-git-send-email-yamada.masahiro@socionext.com>
 <CALCETrVqzidL7SXsCVm8wWrcQMR9dFOLGnDtC-eEYMO4a+yszA@mail.gmail.com>
Message-ID: <CAK7LNARELkQbhAfBdh9Tx7gVGkpN9gTJzoqJwOF-0CH4zm+wcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy

2016-03-14 9:39 GMT+09:00 Andy Lutomirski <luto@amacapital.net>:
> On Mar 12, 2016 4:14 PM, "Masahiro Yamada"
> <yamada.masahiro@socionext.com> wrote:
>>
>> These targets are marked as PHONY.  No need to add FORCE to their
>> dependency.
>
> If this is, in fact, correct, can you update
> Documentation/kbuild/makefiles.txt as well?

Which line do you want me to update?




-- 
Best Regards
Masahiro Yamada
