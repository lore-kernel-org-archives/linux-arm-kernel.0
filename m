From: pascal.huerst@gmail.com (=?ISO-8859-1?Q?Pascal_H=FCrst?=)
Date: Wed, 04 Jun 2014 15:36:22 +0200
Subject: [RFC PATCH 00/11] Embeddable Position Independent Executable
In-Reply-To: <1441820.DP5PYDOd2T@phil>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
 <201310241009.12597.heiko@sntech.de> <1441820.DP5PYDOd2T@phil>
Message-ID: <538F20D6.7030207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ru

On 22.04.2014 10:15, Heiko St?bner wrote:
> Hi Russ,
>
> Am Donnerstag, 24. Oktober 2013, 10:09:12 schrieb Heiko St?bner:
>> Am Dienstag, 17. September 2013, 14:43:26 schrieb Russ Dill:
>>> This patch adds support for and demonstrates the usage of an embedded
>>> position independent executable (PIE). The goal is to allow the use of C
>>> code in situations where carefully written position independent assembly
>>> was previously required.
>>
>> As suggested yesterday evening by Kevin Hilman, just adding my 2ct of
>> support.
>>
>> This series looks exactly like the foundation I'll need at some point in the
>> (probably still distant) future to handle suspend on my Rockchip platform -
>> where like in your example stuff like putting the ram into selfrefresh has
>> to be done by the os.
>
> just as it came up recently again for me and I couldn't find any newer version,
> ist this series still on the table?

We have to maintain quite some patches, to keep pm working for our 
project, so we're interested to get this mainline, too. Is someone 
taking care of these issues? Or is there something i can do to help 
getting this done?

regards
pascal
