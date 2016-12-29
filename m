From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 29 Dec 2016 08:20:49 +0100
Subject: [PATCH V1] pinctrl:pxa:pinctrl-pxa2xx:- No need of devm functions
In-Reply-To: <CACRpkdY8mwHD1yyHZSHsDsJNPjrgLTfEok38FNons6oabn5ZPw@mail.gmail.com>
 (Linus Walleij's message of "Tue, 27 Dec 2016 13:49:06 +0100")
References: <1481207730-6332-1-git-send-email-arvind.yadav.cs@gmail.com>
 <CACRpkdY8mwHD1yyHZSHsDsJNPjrgLTfEok38FNons6oabn5ZPw@mail.gmail.com>
Message-ID: <87o9zvw69a.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Thu, Dec 8, 2016 at 3:35 PM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>
>> In functions pxa2xx_build_functions, the memory allocated for
>> 'functions' is live within the function only. After the
>> allocation it is immediately freed with devm_kfree. There is
>> no need to allocate memory for 'functions' with devm function
>> so replace devm_kcalloc  with kcalloc and devm_kfree with kfree.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>
> I want the maintainer Robert Jarzmik to review this before I do anything

Hi Linus,

I did review, on December the 10th. I wasn't very enthusiastic about the patch,
if you check back my reply.

Cheers.

-- 
Robert
