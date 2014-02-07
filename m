From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 7 Feb 2014 13:48:44 +0800
Subject: [PATCH v9 00/12] Add power management support for mxs phy
In-Reply-To: <e3a207a65094481e9a3e149ac89e6505@BL2PR03MB226.namprd03.prod.outlook.com>
References: <1388111921-17326-1-git-send-email-peter.chen@freescale.com>
 <e3a207a65094481e9a3e149ac89e6505@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <CAL411-pR5BsNLP8cQYv=o_LsnWYnWD6qEYvWFHZz2f-zvxVJLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 2:48 PM, Peter Chen <Peter.Chen@freescale.com> wrote:
>
>
>
>>
>> Hi Felipe & Shawn,
>>
>> The serial adds power management support for MXS PHY, it includes:
>>
>> - Add one PHY API .set_wakeup, and related API implementation at mxs phy
>> driver
>> - misc changes and bug fixes for mxs phy to support low power mode and
>> wakeup.
>>
>> It is based on the lastest Greg's usb-next, 3.13-rc5.
>>
>
> Hi Felipe,
>
> I would like to confirm if this patchset is ok, and will be in
> your 3.15 tree?
>

ping...


-- 
BR,
Peter Chen
