From: olof@lixom.net (Olof Johansson)
Date: Thu, 8 Mar 2012 09:15:08 -0800
Subject: [GIT PULL v4] ARM: kirkwood: fdt conversion progress
In-Reply-To: <201203081610.21493.arnd@arndb.de>
References: <20120307221012.GH5050@titan.lakedaemon.net>
 <201203081610.21493.arnd@arndb.de>
Message-ID: <CAOesGMh2etdQSOjktDGcWGfnsMhyFnVuebWRQeYuR6fvm1_DSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 8, 2012 at 8:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 07 March 2012, Jason Cooper wrote:
>> The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:
>>
>> ? Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)
>>
>> are available in the git repository at:
>> ? git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt
>>
>> ---
>> Arnd,
>>
>> My first two should match up with what you have already, the only
>> outlier is that Jean-Christophe's patch is needed, but I don't think
>> everyone agrees on it yet.
>>
>
> Right now, Olof is handling the pull requests. I would suggest that he
> can use your branch to replace the current staging branch but still keep
> it in staging until everyone agrees or you replace it with a better version.

Jason,

Looking at the new pull request I see some differences in device
support. For example, the DT conversion of orion-spi and wdt is not in
the new branch.

Is that intentional? If not I'll hold off replacing your branch.


-Olof
