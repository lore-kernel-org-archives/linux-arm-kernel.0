From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 29 Jan 2013 21:08:59 +0800
Subject: [PATCH] ARM:common: setting saved_state to NULL after kfree
In-Reply-To: <5107B3B1.1030406@asianux.com>
References: <5107AE6F.3080206@asianux.com>
 <20130129111526.GQ23505@n2100.arm.linux.org.uk>
 <5107B3B1.1030406@asianux.com>
Message-ID: <5107C9EB.6000803@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  it is my fault, building failed for not declare sa1111_remove before using.
  I should notice next time (at least, need building).

  if sending patch v2 is welcome, I will do.
    if need additional test, I should try (I try under qemu virtual machine).

  :-)


gchen.


? 2013?01?29? 19:34, Chen Gang ??:
>> > 2. I don't think you tried to build with your patch in place.
>> > 
>> > 
>   it is my fault, just like what you said, I did not try to build.
>   and I should try now.


-- 
Chen Gang

Asianux Corporation
