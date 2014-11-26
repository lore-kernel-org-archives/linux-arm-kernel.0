From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Nov 2014 17:44:45 -0800
Subject: [PATCH] ARM: exynos: print CPU id on probe
In-Reply-To: <060f01d00919$3aec6e30$b0c54a90$@kernel.org>
References: <1416884886-9896-1-git-send-email-olof@lixom.net>
 <060f01d00919$3aec6e30$b0c54a90$@kernel.org>
Message-ID: <CAOesGMgGm9GenBj4FhceWocGV6M1eO4Hvq-ru+m91_Gsd7aU_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 5:35 PM, Kukjin Kim <kgene@kernel.org> wrote:
> Olof Johansson wrote:
>>
>> It's useful to get the CPU ID/rev printed during boot sometimes, so
>> add a line with that information. Given that the fields have moved
>> within the register over time, don't try to be clever and parse it --
>> just print the raw values for now.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>
>> Kukjin, please apply if you're OK with this. Thanks!
>>
> Yes, why not? I'll apply, I have small concerns for exynos5800 though ;)

That it reports identical to 5422? That's hardly our problem. :-)


-Olof
