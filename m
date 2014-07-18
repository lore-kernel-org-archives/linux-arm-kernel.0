From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Fri, 18 Jul 2014 11:20:42 -0500
Subject: [PATCH 0/2] ARM: minor sigpage enhancements
In-Reply-To: <CAGXu5jJiJw3yk5SKGUk8BTHEd2jTwOKtHFDA2CppzXSy8CGUbg@mail.gmail.com>
References: <1405352767-28768-1-git-send-email-nathan_lynch@mentor.com>
 <CAGXu5jJiJw3yk5SKGUk8BTHEd2jTwOKtHFDA2CppzXSy8CGUbg@mail.gmail.com>
Message-ID: <53C9495A.5040708@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2014 01:57 PM, Kees Cook wrote:
> On Mon, Jul 14, 2014 at 8:46 AM, Nathan Lynch <nathan_lynch@mentor.com> wrote:
>> Russell,
>>
>> Would you consider taking these for 3.17?  I've been carrying the
>> sigpage placement randomization as part of the VDSO patch set but it
>> seems worthwhile on its own.  Using _install_special_mapping for the
>> VDSO and similar VMAs was recently suggested by Andy Lutomirski.
>>
>> Nathan Lynch (2):
>>   ARM: use _install_special_mapping for sigpage
>>   ARM: place sigpage at a random offset above stack
>>
>>  arch/arm/kernel/process.c | 60 ++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 51 insertions(+), 9 deletions(-)
> 
> Cool! Thanks for this.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Russell, okay to add these to your patch tracker?
