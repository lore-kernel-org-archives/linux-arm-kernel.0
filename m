From: k.marinushkin@gmail.com (Kirill Marinushkin)
Date: Sun, 25 Mar 2018 15:54:04 +0200
Subject: [PATCH v4] staging: bcm2835-audio: Release resources on
 module_exit()
In-Reply-To: <CAHp75Vc0ok40nr0OXp4JcnQ77W_BK4PvDPtOY5ObkTXfwpW9cw@mail.gmail.com>
References: <f35d0f86-04b5-6edb-139f-4632edc493b3@gmail.com>
 <20180322213722.31822-1-k.marinushkin@gmail.com>
 <CAHp75VdYiySBzu99MYoBAZ8tORGP1R43z9d+=VRdktg+U=_ZDw@mail.gmail.com>
 <0524fb43-ed08-6c54-39ed-32bd96ccaca4@gmail.com>
 <CAHp75VfJjCHd5U1D22NANLCA1kAoTKLnDGSQPj3ay6OhKSoZxg@mail.gmail.com>
 <4e473a93-317a-5777-7444-6deb105c8f66@gmail.com>
 <CAHp75Vc0ok40nr0OXp4JcnQ77W_BK4PvDPtOY5ObkTXfwpW9cw@mail.gmail.com>
Message-ID: <864c8503-0226-80cf-0140-9e9e33882b22@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/18 15:03, Andy Shevchenko wrote:
> On Sun, Mar 25, 2018 at 1:44 PM, Kirill Marinushkin
> <k.marinushkin@gmail.com> wrote:
>> On 03/25/18 12:33, Andy Shevchenko wrote:
>>> On Fri, Mar 23, 2018 at 9:22 PM, Kirill Marinushkin
>>> <k.marinushkin@gmail.com> wrote:
>>>> On 03/23/18 17:23, Andy Shevchenko wrote:
>>>>> After addressing above, FWIW,
>>>>>
>>>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> Seems you missed my tag in new version.
>>> When someone gives you a tag and you are going to send a new version
>>> (w/o drastic changes), it's your responsibility to append it
>>>
>>> I will send a new mail with it, so, this time no need to resend. Just
>>> keep it for the future contributions.
>>>
>> What is a "tag"?
>> I added in-reply-to this email, I added you as CC.
>> Isn't it enough to keep track of the versioning within a mailing list?
>>
>> Could you please clarify: what "tag" should I usually attach in addition?
> Section 13) in Submitting Patches [1] explains that.
>
> [1]: https://elixir.bootlin.com/linux/v4.16-rc6/source/Documentation/process/submitting-patches.rst
>

Thanks!
