From: gang.chen@asianux.com (Chen Gang)
Date: Fri, 15 Mar 2013 18:36:14 +0800
Subject: [Suggestion] Latest randconfig build errors for Head.S
In-Reply-To: <CAAQYJAvXLV38shKncAKKqgQ9G0SnXjh+=aJHBdhd29yzVtL80A@mail.gmail.com>
References: <51415428.1070401@asianux.com>
 <20130314234323.GD4977@n2100.arm.linux.org.uk> <514270D2.9010205@asianux.com>
 <CAAQYJAvXLV38shKncAKKqgQ9G0SnXjh+=aJHBdhd29yzVtL80A@mail.gmail.com>
Message-ID: <5142F99E.6030607@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?03?15? 17:31, Andrea Adami ??:
> AFAIK Arnd is aware and waiting for feedback about his patch:
> 
> ARM: compressed/head.S: work around new binutils warning   Arnd Bergmann
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/144846.html

  excuse me, I am not familiar with arm assemble code, so can not give more information

  but at least for me, it seems your patch is more precious, and also welcomed by compiler.
  and I don't think your patch make the code "a more complex":
    the reason is:
    "keeping code simple and clear" is for readers and debuggers, not for writers.
    I prefer to write more code to let readers and debuggers easy understand.
      (if it has minor negative effect with performance)

  thanks.

-- 
Chen Gang

Asianux Corporation
