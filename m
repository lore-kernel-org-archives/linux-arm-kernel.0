From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 25 May 2018 09:22:47 +0100
Subject: [PATCH 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
In-Reply-To: <CAPDyKFp3nMoUoM0LfxcSvJKthwrAKK7yCLAkZMGW-oapUsK7GA@mail.gmail.com>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
 <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com>
 <CAPDyKFr_7hbs-MC1jQn5uAgSnb1UGufXZdEmUqNTM63KemTe1g@mail.gmail.com>
 <5a79d3a2-d090-645b-da69-524b7e7a4d90@nvidia.com>
 <51f7de26-579a-8b9e-4e79-f4eee923ab38@codeaurora.org>
 <CAPDyKFo_69kSS6UzdsJeyeiiED=S=chsdkP+R43qMHDEbZ8n_A@mail.gmail.com>
 <3838f17a-2ac8-bf3f-f0b1-f69bbe17629c@nvidia.com>
 <CAPDyKFo8e5FMrxF2ggxVZ+HQjw4s1Wtx-tMf5ka67knJpZMQcA@mail.gmail.com>
 <1687797a-93f1-7e5c-6060-01c12c070964@nvidia.com>
 <CAPDyKFravSx3h6UnsjNGM2ViZtkxvPMULyVQnoVT9jsEP5az+A@mail.gmail.com>
 <96169281-49b2-121f-0b7e-f54aae66db91@nvidia.com>
 <CAPDyKFp3nMoUoM0LfxcSvJKthwrAKK7yCLAkZMGW-oapUsK7GA@mail.gmail.com>
Message-ID: <a8064cdb-d11d-ef85-1da3-28113b86af3b@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 24/05/18 22:21, Ulf Hansson wrote:

...

>> OK, so this bit is a to-do as that is not yet exposed AFAICT. I see that you
>> said 'although we need to extend it to cover cleanup of the earlier
>> registered device, via calling device_unregister().' So if we do this then
>> that would be fine.
> 
> Let me clarify the changelog. It's not a to-do, as it's already done
> as part of $subject patch.

Yes I see it now. OK, then that's fine.

Jon

-- 
nvpublic
