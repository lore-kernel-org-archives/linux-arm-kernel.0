From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 14 Aug 2014 12:19:33 -0500
Subject: Option CONFIG_DEBUG_SET_MODULE_RONX not working for kernel 3.10
In-Reply-To: <CAPrYoTGBZ5EwBYt35TbtORo1_VKG6S=onAnB8Stkte7V_S9uOQ@mail.gmail.com>
References: <CAPrYoTGBZ5EwBYt35TbtORo1_VKG6S=onAnB8Stkte7V_S9uOQ@mail.gmail.com>
Message-ID: <53ECEFA5.8070206@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2014 05:24 AM, Chetan Nanda wrote:
> Hi,
> 
> I am trying to enable 'CONFIG_DEBUG_SET_MODULE_RONX' config option on
> 3.10 kernel via writing  CONFIG_DEBUG_SET_MODULE_RONX=y at the end of
> board specific config file.
> 
> But .config generated after kernel build do not have this option enabled.

That feature appears to have been added well after 3.10, so unless
you've backported it, this is expected behavior.
