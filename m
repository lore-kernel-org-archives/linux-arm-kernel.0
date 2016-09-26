From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Sep 2016 10:55:21 -0300
Subject: [PATCH v4 2/5] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <CAOf5uw=HwErWWqvQ30ZJpb3CupqdvGZ9FnGAxh4+JVTrT6wTjw@mail.gmail.com>
References: <1473618641-10159-1-git-send-email-jagan@amarulasolutions.com>
 <1473618641-10159-3-git-send-email-jagan@amarulasolutions.com>
 <CAOMZO5CsrrqqUPaVbU-ya79VSXgxyspa_fbr8HY1voJgpy2LLg@mail.gmail.com>
 <CAMty3ZDKrXxmwDFxSBvL_anJQPdXEfnJ40uNv5B6KssQyJJKhA@mail.gmail.com>
 <CAOMZO5B_ahBJr_Tgz_HShmG9heUwCj4K0N3FHhxja1yg0gCUGA@mail.gmail.com>
 <CAOf5uw=bMMa98RP=kvA=NfS89TWOEqU3Q2HjpEmzUTVrdg2=sQ@mail.gmail.com>
 <CAOMZO5CnP3=CNnQcOzra7eQ-cAwProgH+Kws0FHVOw7Q6nCDow@mail.gmail.com>
 <119ad2fc-8e74-1193-8ee2-417cf1e6fd49@engicam.com>
 <CAOMZO5BWgqxfbOepJZwqdZceSWKBnSfd38Ab2TV-LN0oDttc-Q@mail.gmail.com>
 <CAOf5uw=HwErWWqvQ30ZJpb3CupqdvGZ9FnGAxh4+JVTrT6wTjw@mail.gmail.com>
Message-ID: <CAOMZO5BHhA8rd0URLNGGLZKN00zFz9d5vsq4CuRWsKyT6yq-oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2016 at 10:54 AM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:

>> Why don't you simply do like this?
>>
>>        reg_3p3v: regulator-3p3v {
>>                compatible = "regulator-fixed";
>>                regulator-name = "3P3V";
>>                regulator-min-microvolt = <3300000>;
>>                regulator-max-microvolt = <3300000>;
>>        };
>
> Should dts rispect the schematic connection?

Yes
