From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 9 Mar 2016 19:53:06 +0530
Subject: [PATCH 00/50] pinctrl: Add and use devm_ apis for
 pinctrl_{register, unregister}
In-Reply-To: <56D307CC.2050202@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <CACRpkdZjv2KZ0AtC9oBytmSdS+=T+kC8PoJVt-RawE8Np8p40w@mail.gmail.com>
 <56D307CC.2050202@nvidia.com>
Message-ID: <56E031CA.9010204@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sunday 28 February 2016 08:14 PM, Laxman Dewangan wrote:
>
> On Thursday 25 February 2016 07:43 PM, Linus Walleij wrote:
>> On Wed, Feb 24, 2016 at 2:15 PM, Laxman Dewangan 
>> <ldewangan@nvidia.com> wrote:
>>
>>> Add resource manageemnt APIs fro pinctrl_register() and 
>>> pinctrl_unregister()
>>> and use these new APIs on hw driver to reduce the error path code and
>>> remove callback for driver.
>> As you can probably guess I like this too, so wait a while, collect ACKs
>> and send me a branch to pull for this too.
>>
> Got lots of ack/reviewed by and captured all. Also did code changes 
> per review:
> - Optimizing in devm_ apis.
> - Correcting the description of devm_ apis.
> - Simplifying probe in digicolor.
> - Removing unwanted pfc->pinctrl in ish.
>
> Pushed the change at:
> Branch "devm_pinctrl_register" of 
> https://github.com/ldewangan/linux-upstream.git.
>
> Base repo is
> for-next of 
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
>
>
> If required, I can send the V2 version of list with acks.
>

Let me know if I need to send full series (V2 with collected ack) again 
or fine to pull it from above location.


Thanks,
Laxman
