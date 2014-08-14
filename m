From: chetannanda@gmail.com (Chetan Nanda)
Date: Thu, 14 Aug 2014 15:54:29 +0530
Subject: Option CONFIG_DEBUG_SET_MODULE_RONX not working for kernel 3.10
Message-ID: <CAPrYoTGBZ5EwBYt35TbtORo1_VKG6S=onAnB8Stkte7V_S9uOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to enable 'CONFIG_DEBUG_SET_MODULE_RONX' config option on
3.10 kernel via writing  CONFIG_DEBUG_SET_MODULE_RONX=y at the end of
board specific config file.

But .config generated after kernel build do not have this option enabled.

Do I need to enable any other option also before enabling this one?


Thanks,
Chetan Nanda
