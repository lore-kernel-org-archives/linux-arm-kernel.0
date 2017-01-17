From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 15:43:25 -0800
Subject: [PATCH net-next v4 05/10] drivers: base: Add
 device_find_in_class_name()
In-Reply-To: <CAHp75VfE8t+_2Yu1NYMErKopnCNwFakO6pyDRmqAU-ZsGuyvmg@mail.gmail.com>
References: <20170117232152.1661-1-f.fainelli@gmail.com>
 <20170117232152.1661-6-f.fainelli@gmail.com>
 <CAHp75VfE8t+_2Yu1NYMErKopnCNwFakO6pyDRmqAU-ZsGuyvmg@mail.gmail.com>
Message-ID: <b8cc0d2f-f544-0e06-32bd-47e6b9be5393@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 03:34 PM, Andy Shevchenko wrote:
> On Wed, Jan 18, 2017 at 1:21 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> Add a helper function to lookup a device reference given a class name.
>> This is a preliminary patch to remove adhoc code from net/dsa/dsa.c and
>> make it more generic.
> 
> 
>> +static int device_class_name_match(struct device *dev, void *class)
> 
> And why not const char *class?

This was raised back in v2, and the same response applies:

https://www.mail-archive.com/netdev at vger.kernel.org/msg147559.html

Changing the signature of a callback is out of the scope of this patch
series.
-- 
Florian
