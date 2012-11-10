From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 10 Nov 2012 22:33:49 +0100
Subject: [PATCH 2/2] ARM: S3C64XX: Staticly define parent clock of "camera"
 clock
In-Reply-To: <509EC391.9090506@gmail.com>
References: <1352556477-3700-1-git-send-email-y>
 <509e6047.a766980a.0f91.14f6@mx.google.com> <509EC391.9090506@gmail.com>
Message-ID: <509EC83D.8010704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2012 10:13 PM, Sylwester Nawrocki wrote:
> On 11/10/2012 03:07 PM, dron0gus at gmail.com wrote:
>> From: Andrey Gusakov<dron_gus@mail.ru>
>>
>> The "camera" clock have only one parent. Define it staticly and

Forgot to point out a small typo here: staticly -> statically.

>> remove unused source clock list.
>>
>> Signed-off-by: Andrey Gusakov<dron0gus@gmail.com>
>
> Reviewed-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
