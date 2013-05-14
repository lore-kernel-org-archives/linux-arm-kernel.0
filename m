From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 14 May 2013 15:17:36 +0800
Subject: [PATCH] pinctrl:sirf:re-arch and add support for new SiRFatlas6
 SoC
In-Reply-To: <CACRpkda+ghKMkXFQzkJ7uauwGWGNrn4aqyYajt9U9RYkmvT-6g@mail.gmail.com>
References: <1363597988-7409-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdYUTQ_7V1CbKbx05zgBONj6iUi=ekzSwmZz8dqeRx7ZJw@mail.gmail.com>
 <CAGsJ_4wmn-LxxX-JeSJzdkVFSUeJ=vQrKHJr9yUtsoxG2BFHtw@mail.gmail.com>
 <CACRpkdaMYTXpnfg8MhRP5Fs_Qn2gwv=Xuk3YSYejxt+vK9D6+w@mail.gmail.com>
 <CAGsJ_4xSk_fXjhM2kxy0Hd36e9BsGshfmM97KgcU3cC5avmxtQ@mail.gmail.com>
 <CACRpkda+ghKMkXFQzkJ7uauwGWGNrn4aqyYajt9U9RYkmvT-6g@mail.gmail.com>
Message-ID: <CAGsJ_4xUBHiSkgxXRMZNAm0-6nOrdKwSZi0Am+6Nh5PJRxFGMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/4/9 Linus Walleij <linus.walleij@linaro.org>:
> On Sun, Apr 7, 2013 at 5:03 AM, Barry Song <21cnbao@gmail.com> wrote:
>> 2013/4/3 Linus Walleij <linus.walleij@linaro.org>:
>>> On Thu, Mar 28, 2013 at 7:27 AM, Barry Song <21cnbao@gmail.com> wrote:
>>>> 2013/3/28, Linus Walleij <linus.walleij@linaro.org>:
>>>
>>>>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>>>>
>>>>> This is OK but can you please:
>>>>
>>>> ok. one issue is recently Arnd has given another changes in
>>>> pinctrl-sirf in arm-soc multiple platform branch:
>>>> https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=prima2/multiplatform&id=67d71344fd09223820eb9de39b597ec29f035e89
>>>>
>>>> it makes us easily to get merging conflict. what is your suggestion
>>>> about taking all these changes in 3.10?
>>>
>>> Please send this to where the rest of the patches are with my ACK
>>> (I guess the ARM SoC tree?)
>>
>> unfortunately, this is not in arm soc:
>> Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> pinctrl: sirf: using for_each_set_bit to simplify the code
>>
>> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=for-next&id=3dcbd6f5789839c7fea8841088ed3a28688f81ed
>>
>> i think there will still be some merge conflict. so to make people
>> easy, i might wait for 3.11 and resend the patch with your ack, then
>> you apply it on pinctrl tree.
>
> OK let's do it like that.

done by "[PATCH RESEND] pinctrl:sirf:re-arch and add support for new
SiRFatlas6 SoC"

> Linus Walleij

-barry
