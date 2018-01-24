From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 24 Jan 2018 17:48:03 +0200
Subject: [PATCH RFC 0/3] API for 128-bit IO access
In-Reply-To: <CAK8P3a3TEV7Uyo_oBcMz_GYEYTB+V5AhDgbOgCEW-+X1h7sXEg@mail.gmail.com>
References: <20180124090519.6680-1-ynorov@caviumnetworks.com>
 <CAK8P3a3TEV7Uyo_oBcMz_GYEYTB+V5AhDgbOgCEW-+X1h7sXEg@mail.gmail.com>
Message-ID: <CAHp75VfWZOAMRaWTa-PZP68tDtXCydNYbGF+8y11L_yMWfP1iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 12:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jan 24, 2018 at 10:05 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:

>> * For 128-bit read/write functions I take suffix 'o', which means read/write
>> the octet of bytes. Is this name OK?
>
> Can't think of anything better. It's not an octet though, but 16 bytes
> ('q' is for quadword, meaning four 16-bit words in Intel terminology).

It's apparently follows Intel's terminology by implying "word", so, "octetword".

-- 
With Best Regards,
Andy Shevchenko
