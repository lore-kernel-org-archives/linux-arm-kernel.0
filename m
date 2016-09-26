From: matteo.lisi@engicam.com (Matteo Lisi)
Date: Mon, 26 Sep 2016 15:44:05 +0200
Subject: [PATCH v4 2/5] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <CAOMZO5CnP3=CNnQcOzra7eQ-cAwProgH+Kws0FHVOw7Q6nCDow@mail.gmail.com>
References: <1473618641-10159-1-git-send-email-jagan@amarulasolutions.com>
 <1473618641-10159-3-git-send-email-jagan@amarulasolutions.com>
 <CAOMZO5CsrrqqUPaVbU-ya79VSXgxyspa_fbr8HY1voJgpy2LLg@mail.gmail.com>
 <CAMty3ZDKrXxmwDFxSBvL_anJQPdXEfnJ40uNv5B6KssQyJJKhA@mail.gmail.com>
 <CAOMZO5B_ahBJr_Tgz_HShmG9heUwCj4K0N3FHhxja1yg0gCUGA@mail.gmail.com>
 <CAOf5uw=bMMa98RP=kvA=NfS89TWOEqU3Q2HjpEmzUTVrdg2=sQ@mail.gmail.com>
 <CAOMZO5CnP3=CNnQcOzra7eQ-cAwProgH+Kws0FHVOw7Q6nCDow@mail.gmail.com>
Message-ID: <119ad2fc-8e74-1193-8ee2-417cf1e6fd49@engicam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Our SOM doesn't use external PMIC.

We powered all devices with a fix voltage regulators that cannot be 
drive directly from SoC so
any external power rail can be driven by drivers.

Regards

Matteo



Il 21/09/2016 18:46, Fabio Estevam ha scritto:
> Hi Michael,
>
> On Tue, Sep 20, 2016 at 10:23 AM, Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
>
>> Engicam use fixed regulator always on and on on boot. Their board does
>> not have any
>> external pmu. Is this answer to your comment?
> All I am saying is that  "regulator-boot-on" and "regulator-always-on"
> properties should be removed.
>
> The "reg_3p3v" regulator will be turned on and off by the flexcan driver.
>


-- 

------------------------------------------------------------------------
http://www.engicam.com <http://www.engicam.com>

*/ENGICAM /*s.r.l.
50018 Scandicci - FIRENZE
Via dei Pratoni, 16
Tel. +39 055 7311387
Fax. +39 055 720608
Web www.engicam.com <http://www.engicam.com>

C.F./P.I. 05389070482
Registro Imprese di FIRENZE 542918
Capitale sociale i.v. 50.000,00?
------------------------------------------------------------------------
NOTICE: This message and attachments are intended only for the use of 
their addresses and may contain confidential information belonging to 
Engicam. If you are not the intended recipient, you are hereby notified 
that any reading, dissemination, distribution, or copying of this 
message, or any attachment, is strictly prohibited. If you have received 
this message in error, please notify the original sender immediately and 
delete this message, along with any attachments.
