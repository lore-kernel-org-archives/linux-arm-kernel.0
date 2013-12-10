From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 10 Dec 2013 09:05:11 -0800
Subject: [PATCH v3 2/3] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <CAMuHMdV6RN4E7xez9xXLbcbp0Ga9zu09ndfa7b_YiobdQypc4w@mail.gmail.com>
References: <201312082348.17588.sergei.shtylyov@cogentembedded.com>
 <201312082352.45265.sergei.shtylyov@cogentembedded.com>
 <CAMuHMdWFmO4d4b77JDY0_Z5NuQFoP73-PVho2dwAOY4ES57Dug@mail.gmail.com>
 <52A62753.8060202@cogentembedded.com>
 <CAMuHMdXDHMRy2LTEa50omMs0dV9Vdf2woBsNAHzhkceXDfqyOg@mail.gmail.com>
 <52A64DCB.8000504@cogentembedded.com>
 <CAMuHMdV6RN4E7xez9xXLbcbp0Ga9zu09ndfa7b_YiobdQypc4w@mail.gmail.com>
Message-ID: <CAGVrzcZ7Pm69UpUeLoh4oz_uh6jQeVMkqjpZc=Rh3dyyCPOgpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/12/10 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Tue, Dec 10, 2013 at 12:10 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
>>>>     You can try my simplistic 'sh_eth' driver patch:
>>
>>>> http://marc.info/?l=linux-sh&m=137911743723032
>>
>>> Thanks, that also fixes the problem!
>>
>>    Let's hope Florian's patches get queued for 3.14. You can also test them
>> meanwhile...
>
> I applied the whole series "net: phy: consolidate PHY reset", and sh_eth
> now works fine on Koelsch.

Great! Thanks Geert.
--
Florian
