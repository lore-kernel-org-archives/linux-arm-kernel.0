From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 18 Mar 2018 18:23:15 -0700
Subject: [PATCH v2 0/7] KASan for arm
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C0076FBE@dggemm510-mbs.china.huawei.com>
References: <B8AC3E80E903784988AB3003E3E97330C0076FBE@dggemm510-mbs.china.huawei.com>
Message-ID: <b9a813b8-30fe-ef17-ff79-372c2134723f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/18/2018 06:20 PM, Liuwenliang (Abbott Liu) wrote:
> On 03/19/2018 03:14 AM, Florian Fainelli wrote:
>> Thanks for posting these patches! Just FWIW, you cannot quite add
>> someone's Tested-by for a patch series that was just resubmitted given
>> the differences with v1. I just gave it a spin on a Cortex-A5 (no LPAE)
>> and it looks like test_kasan.ko is passing, great job!
> 
> I'm sorry.
> Thanks for your testing very much!
> I forget to add Tested-by in cover letter patch file. But I have alreadly added
> Tested-by in some of following patch. 
> In the next version I am going to add Tested-by in all patches.

This is not exactly what I meant. When you submit a v2 of your patches,
you must wait for people to give you their test results. The Tested-by
applied to v1, and so much has changed it is no longer valid for v2
unless someone tells you they tested v2. Hope this is clearer.
-- 
Florian
