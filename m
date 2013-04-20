From: gang.chen@asianux.com (Chen Gang)
Date: Sat, 20 Apr 2013 09:55:07 +0800
Subject: [PATCH] ARM64: kernel: compiling issue, duplicate definition
 of early_console
In-Reply-To: <201304191415.31986.arnd@arndb.de>
References: <5152DB83.8080703@asianux.com> <516E66F9.9070904@asianux.com>
 <51712213.4060607@asianux.com> <201304191415.31986.arnd@arndb.de>
Message-ID: <5171F57B.7090305@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?19? 20:15, Arnd Bergmann wrote:
> On Friday 19 April 2013, Chen Gang wrote:
>> >   when compiling with allmodconfig.
>> >     early_console is already defined as an extern global pointer.
>> > 
>> >   need let it point to the object which we intend to (like ARM32 done).
>> > 
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> 

  thanks

-- 
Chen Gang

Asianux Corporation
