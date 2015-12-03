From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 3 Dec 2015 15:45:54 -0200
Subject: mx28: bad unlock balance detected
In-Reply-To: <20151127121126.GM1929@sirena.org.uk>
References: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
 <20151127121126.GM1929@sirena.org.uk>
Message-ID: <CAOMZO5D-PKSZ76uLxEwtK9K6X3j5OnWd-cJZTz3U9p4EkyJ4hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 10:11 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Nov 26, 2015 at 02:18:04PM -0200, Fabio Estevam wrote:
>> Hi,
>>
>> Running linux-next 20151126 on a mx28evk leads to the following bug:
>>
>> sgtl5000 0-000a: sgtl5000 revision 0x11
>> sgtl5000 0-000a: Using internal LDO instead of VDDD
>>
>> =====================================
>> [ BUG: bad unlock balance detected! ]
>> 4.4.0-rc2-next-20151126-00001-g44eb6b2 #156 Not tainted
>
> This should be fixed in the next -next, Arnd noticed a problem with his
> code.

That's correct. linux-next 20151202 does not show the problem, thanks.
