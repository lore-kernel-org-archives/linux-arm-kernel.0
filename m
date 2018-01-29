From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 29 Jan 2018 18:31:41 +0100
Subject: [PATCH v1] ARM: pxa/raumfeld: use PROPERTY_ENTRY_U32() directly
In-Reply-To: <1517238114.7000.1299.camel@linux.intel.com> (Andy Shevchenko's
 message of "Mon, 29 Jan 2018 17:01:54 +0200")
References: <20180122125529.6291-1-andriy.shevchenko@linux.intel.com>
 <1517238114.7000.1299.camel@linux.intel.com>
Message-ID: <87tvv48tc2.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Mon, 2018-01-22 at 14:55 +0200, Andy Shevchenko wrote:
>> Instead of using PROPERTY_ENTRY_INTEGER() with explicitly supplied
>> type,
>> use PROPERTY_ENTRY_U32() dedicated macro.
>> 
>> It will help modify internals of built-in device properties API.
>> 
>> No functional change intended.
>> 
>
> Can someone apply that, or at least Ack? It's needed as a prerequisite
> to fix one bug in device property core API.
I can certainly ack it :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

I would have gladly taken it into my pxa/for-next branch, but for a reason your
original mail did not land in my mailbox ... computers can be deceiving
sometimes.

I you send it to me again I'll apply it to my tree.

Cheers.

--
Robert
