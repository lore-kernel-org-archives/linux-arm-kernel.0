From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 27 Jun 2018 11:05:36 +0200
Subject: [PATCH v2 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to
 manage multi PM domains
In-Reply-To: <ebec2f66-d28d-7b94-3cef-be980617cd6f@codeaurora.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-10-ulf.hansson@linaro.org>
 <cc6f36ce-32b7-4b69-f9a9-98cf0b12a9d1@nvidia.com>
 <CAPDyKFoiEctBuyw1nVS6ruQ92-jOsMMSAUsWKew42dkmk64_8A@mail.gmail.com>
 <f214cf2b-49ee-2f7c-babd-1cee7dcae927@nvidia.com>
 <ebec2f66-d28d-7b94-3cef-be980617cd6f@codeaurora.org>
Message-ID: <CAPDyKFqZVLfKXK7H+VLaiTh96xRwqBWHxaFfs5PDo7o+5hzRsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 June 2018 at 10:55, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> On 05/30/2018 08:00 PM, Jon Hunter wrote:
>>>> My only other comments on this series are ...
>>>>
>>>> 1. I think it would be nice to have an dev_pm_domain_attach_by_name() and
>>>>    that the DT binding has a 'power-domain-names' property.
>>> I think it makes sense, but my plan was to do that as second step on
>>> top. Are you okay with that as well?
>> Yes that is fine with me.
>
> Ulf, do you have a patch for this? I am working on moving some of qcom
> remoteproc drivers to use this series and it will help to have a
> dev_pm_domain_attach_by_name() api.

Right. Besides this I have been working on a little improvement,
avoiding to power the PM domain while attaching.

I post a series in a day or two.

Kind regards
Uffe
