From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:08:02 +0100
Subject: [PATCH resend^2] ARM: nspire: Remove unneeded nspire_map_io()
In-Reply-To: <f87260a9-66a9-1f5c-4787-2632ad3daafb@arm.com>
References: <1519997885-12374-1-git-send-email-geert+renesas@glider.be>
 <f87260a9-66a9-1f5c-4787-2632ad3daafb@arm.com>
Message-ID: <CAK8P3a1L=2KdzdfYr+B3pEnvQQ4NA2+wuhhRuQMMdfQE4tSsGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2018 at 2:49 PM, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> On 02/03/18 13:38, Geert Uytterhoeven wrote:
>> nspire_map_io() just calls debug_ll_io_init().
>>
>> If machine_desc.map_io is not set, devicemaps_init() in the
>> common ARM code will call debug_ll_io_init(), so nspire_map_io() and the
>> initialization of .map_io can be removed.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Applied to next/soc, thanks!

       Arnd
