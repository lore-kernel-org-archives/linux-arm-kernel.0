From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 12 Oct 2010 11:58:39 +0300
Subject: Machine name/id change request
In-Reply-To: <20100920155806.GA5177@n2100.arm.linux.org.uk>
References: <AANLkTikm78_dj03xxaHMi10V+_B9B_8FRg1kRbL2OPBK@mail.gmail.com>
	<20100920154441.GG30793@n2100.arm.linux.org.uk>
	<AANLkTinBw_NJj=BcAOq5BzPGqrO8FW7fzmUVK8TGH7A7@mail.gmail.com>
	<20100920155806.GA5177@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin6zJQxOLBuGkYgNp3nLT4viN1bDcLiryUim18h@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 6:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 20, 2010 at 06:48:54PM +0300, Amit Kucheria wrote:
>> On Mon, Sep 20, 2010 at 6:44 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Sep 20, 2010 at 10:32:51AM -0500, Matt Sealey wrote:
>> >> Hello,
>> >>
>> >> Is it possible for us to change a machine name/id in the database and
>> >> future kernels?
>> >>
>> >> We have two systems originally designed by Pegatron and registered
>> >> under their codenames, but for now retailing and marketed under the
>> >> "Efika MX" brand. We would like to change the id data for
>> >>
>> >> id 2336, originally MX51_LANGE51 but changed to MX51_EFIKAMX (mx51_efikamx etc.)
>> >> id 2370, originally MX51_KUNLUN but changed to MX51_EFIKASB (mx51_efikasb etc.)
>> >
>> > As they're not in mainline then we can. ?Bear in mind that kernels
>> > which contain this code using the old identifiers will break when
>> > someone decides to download a new copy of the file after the change.
>> >
>> > Updated.
>> >
>> > Is Sean Hsieh still responsible for these?
>>
>> You can add my name there since I'll be submitting the board files.
>
> Remind me to fix it up when you submit something to the patch system/
> machine registry. ?Neither Matt nor yourself currently appears in
> the existing list of people...
>

Russell,

Sascha has now accepted patches to enable the machine (EFIKAMX) in his
imx tree. Could you please add me to the list as maintainer?

Regards,
Amit
