From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Mon, 26 Sep 2016 15:54:02 +0200
Subject: [PATCH v4 2/5] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <CAOMZO5BWgqxfbOepJZwqdZceSWKBnSfd38Ab2TV-LN0oDttc-Q@mail.gmail.com>
References: <1473618641-10159-1-git-send-email-jagan@amarulasolutions.com>
 <1473618641-10159-3-git-send-email-jagan@amarulasolutions.com>
 <CAOMZO5CsrrqqUPaVbU-ya79VSXgxyspa_fbr8HY1voJgpy2LLg@mail.gmail.com>
 <CAMty3ZDKrXxmwDFxSBvL_anJQPdXEfnJ40uNv5B6KssQyJJKhA@mail.gmail.com>
 <CAOMZO5B_ahBJr_Tgz_HShmG9heUwCj4K0N3FHhxja1yg0gCUGA@mail.gmail.com>
 <CAOf5uw=bMMa98RP=kvA=NfS89TWOEqU3Q2HjpEmzUTVrdg2=sQ@mail.gmail.com>
 <CAOMZO5CnP3=CNnQcOzra7eQ-cAwProgH+Kws0FHVOw7Q6nCDow@mail.gmail.com>
 <119ad2fc-8e74-1193-8ee2-417cf1e6fd49@engicam.com>
 <CAOMZO5BWgqxfbOepJZwqdZceSWKBnSfd38Ab2TV-LN0oDttc-Q@mail.gmail.com>
Message-ID: <CAOf5uw=HwErWWqvQ30ZJpb3CupqdvGZ9FnGAxh4+JVTrT6wTjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, Sep 26, 2016 at 3:47 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Matteo,
>
> On Mon, Sep 26, 2016 at 10:44 AM, Matteo Lisi <matteo.lisi@engicam.com> wrote:
>> Hi Fabio,
>>
>> Our SOM doesn't use external PMIC.
>>
>> We powered all devices with a fix voltage regulators that cannot be drive
>> directly from SoC so
>> any external power rail can be driven by drivers.
>
> Sure, this is fine.
>
> Why don't you simply do like this?
>
>        reg_3p3v: regulator-3p3v {
>                compatible = "regulator-fixed";
>                regulator-name = "3P3V";
>                regulator-min-microvolt = <3300000>;
>                regulator-max-microvolt = <3300000>;
>        };

Should dts rispect the schematic connection?


Michael


-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
