From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Sep 2016 23:49:34 +0200
Subject: [GIT PULL] Qualcomm EBI2 bindings and bus driver
In-Reply-To: <4360974.U0qvolVKdi@wuerfel>
References: <CACRpkdYvowN2htUuN46JNVdfaKNw3AEbBfzAeScHQcLU5o3ZUg@mail.gmail.com>
 <4360974.U0qvolVKdi@wuerfel>
Message-ID: <CACRpkdZNpUshQckCPEid0fcnSLeKFPm9Rie4TA25pCjwhY22vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 12:12 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday, September 8, 2016 3:34:42 PM CEST Linus Walleij wrote:
>> please pull this new EBI2 bus driver and its bindings into an
>> apropriate branch in the ARM SoC tree. The binding now has
>> Rob Herrings ACK and we have hopefully finally figured out how
>> this should be done.
>>
>
> I just noticed that you sent the pull request directly to arm at kernel.org
> rather than the Qualcomm maintainers (which are only on Cc).
>
> Usually, I'd expect to see this forwarded from Andy, is there a
> reason to do it differently here? If so, can I have an Ack
> from him?

Sorry I sent it like this beacuse in an earlier revision of the patch
I asked how it was to be handled and got no answers, so I just assumed
new drivers was a plain separate thing. (I understand Andy has to merge
the DTS changes.)

I saw Andy gave his ACK though, any comments should be addressed
in this version as well.

Yours,
Linus Walleij
