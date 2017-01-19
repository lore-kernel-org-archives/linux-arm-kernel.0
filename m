From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Thu, 19 Jan 2017 09:51:35 -0800
Subject: [PATCH v3 0/4] ARM: K2G: Add support for TI-SCI Generic PM Domains
In-Reply-To: <bf9286b1-379d-1cc8-4eae-d268540dd2a6@ti.com>
References: <20170104205536.15963-1-d-gerlach@ti.com>
 <6fc7a6cb-1856-1377-b00c-8166dbb23ea2@oracle.com>
 <bf9286b1-379d-1cc8-4eae-d268540dd2a6@ti.com>
Message-ID: <25026532-fe4d-8215-9249-c5c7efcd8242@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/4/17 2:06 PM, Dave Gerlach wrote:
> Santosh,
> On 01/04/2017 03:54 PM, Santosh Shilimkar wrote:
>> On 1/4/2017 12:55 PM, Dave Gerlach wrote:
>>> Hi,
>>> This is v3 of the series to add support for TI-SCI Generic PM Domains.
>>> Previous versions can be found here:
>>>
>>> v2: https://www.spinics.net/lists/kernel/msg2364612.html
>>> v1: http://www.spinics.net/lists/arm-kernel/msg525204.html
>>>
>>> This version is rebased on v4.10-rc2 but is the same as v2 with the
>>> exception of patch 2 in which the devicetree binding documentation
>>> needed to be updated to show the k2g_pds node should be a child of
>>> the pmmc node. Apart from that, the acks provided by Ulf were added
>>> to patches 1 and 3.
>>>
>>> Now that the TI-SCI series has been merged [1] this series will be ready
>>> to go in with an ack on the DT binding. Rob had raised some questions on
>>> the necessity ti,sci-id property but I believe these were properly
>>> addressed during the discussion of v2 so hopefully an ack is in order
>>> now.
>>>
>> How do you plan to merge this series with below patch ?
>>
>>>   PM / Domains: Add generic data pointer to genpd data struct
>> I think this one goes via Rafael's tree. If you want me to merge this
>> along with other patches then will need his ack.
>>
>> Other way is to get that merged first via Rafael's tree and then
>> the remainder series.
>
> I'd be happy with it going in through your tree with an ack to avoid any
> delay but I'd say it's Rafael's call as it is a patch to the genpd core,
> even though at this point I am the only user.
>
Am going to send pull request over weekend, so if you would like
me take the series via arm-soc tree, please get Rafaels, ack and
let me know.

Regards,
Santosh
