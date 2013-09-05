From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 5 Sep 2013 17:45:35 +0200
Subject: [PATCH 3/3] perf: parse the .debug_frame section in case
 .eh_frame is not present
In-Reply-To: <CAFrcx1=V7zRuK767RHCXbu99Mtf+VZrmv7_4mOn7Kb6B8cd2sQ@mail.gmail.com>
References: <1378317854-25965-1-git-send-email-jean.pihet@linaro.org>
 <1378317854-25965-4-git-send-email-jean.pihet@linaro.org>
 <20130905124508.GE9696@mudshark.cambridge.arm.com>
 <CAORVsuW-1koTMaSMgjagBz1aJ0AtvVRiM5gs3kwO2Fuvk+DhwQ@mail.gmail.com>
 <CAKv+Gu8u4PLVfng8ru4RFwA-+Ky0vYEP3V2=vecqndo5Z0sTJg@mail.gmail.com>
 <20130905131910.GB22351@mudshark.cambridge.arm.com>
 <CAFrcx1koLAnNRBtpAhOoTP0SC-wWknY7ipUmcvnjxKqwDOUmag@mail.gmail.com>
 <CAFrcx1=V7zRuK767RHCXbu99Mtf+VZrmv7_4mOn7Kb6B8cd2sQ@mail.gmail.com>
Message-ID: <CAKv+Gu9KYonToLdhnVeMpfm41zYydo9EqxM+a-6iVGQNgZz5hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 September 2013 17:29, Jean Pihet <jean.pihet@linaro.org> wrote:

[...]

> The segfault is caused by libunwind. With the latest version [1],
> dwarf unwinding works fine.
> Investigation on-going, more to come!
>
> [1] git://git.sv.gnu.org/libunwind.git
>

I managed to get it to work by upgrading to Ubuntu Saucy's libunwind8
on a Ubuntu Raring system (Calxeda Highbank)

FWIW, for the series

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # on
ARM/Highbank/UbuntuSaucy

-- 
Ard.
