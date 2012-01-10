From: shubhrajyoti@ti.com (Datta, Shubhrajyoti)
Date: Tue, 10 Jan 2012 12:10:41 +0530
Subject: [PATCH] OMAP: I2C: add devexit to the remove code
In-Reply-To: <20120106162820.GB8441@trinity.fluff.org>
References: <1324365959-4143-1-git-send-email-shubhrajyoti@ti.com>
 <20120106162820.GB8441@trinity.fluff.org>
Message-ID: <CANQgH-YunVKm7eG4kv8LXQdZrEAPkQGesNbxmN-rmNFJB_dR8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 6, 2012 at 9:58 PM, Ben Dooks <ben-i2c@fluff.org> wrote:
> On Tue, Dec 20, 2011 at 12:55:59PM +0530, Shubhrajyoti D wrote:
>> The omap_i2c_remove function may not be needed after
>> device exit so the memory could be freed.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> Will add this later.

OK thanks.
