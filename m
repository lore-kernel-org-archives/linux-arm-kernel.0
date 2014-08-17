From: chetannanda@gmail.com (Chetan Nanda)
Date: Sun, 17 Aug 2014 13:25:27 +0530
Subject: Option CONFIG_DEBUG_SET_MODULE_RONX not working for kernel 3.10
In-Reply-To: <53ECEFA5.8070206@mentor.com>
References: <CAPrYoTGBZ5EwBYt35TbtORo1_VKG6S=onAnB8Stkte7V_S9uOQ@mail.gmail.com>
 <53ECEFA5.8070206@mentor.com>
Message-ID: <CAPrYoTGDBrfEvwo6RgXeH_-7UCHgWOKR+=vS15HSapvK8K_quA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 10:49 PM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> On 08/14/2014 05:24 AM, Chetan Nanda wrote:
>> Hi,
>>
>> I am trying to enable 'CONFIG_DEBUG_SET_MODULE_RONX' config option on
>> 3.10 kernel via writing  CONFIG_DEBUG_SET_MODULE_RONX=y at the end of
>> board specific config file.
>>
>> But .config generated after kernel build do not have this option enabled.
>
> That feature appears to have been added well after 3.10, so unless
> you've backported it, this is expected behavior.
>
 Hi Nathan,
Thanks for you mail, It seems that support is there in 3.10 kernel
(atleast module.c file contains this flag) could be that CONFIG
support for ARM is missing,
As there is no entry for this flag in arm/Kconfig.debug.

Thanks,
Chetan Nanda
