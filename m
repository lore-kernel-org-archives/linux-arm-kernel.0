From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Sat, 24 Jan 2015 18:33:00 +0100
Subject: [PATCH 1/2] ARM: ux500: Move struct
In-Reply-To: <20150122074458.GL22024@x1>
References: <1421881782-23716-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <20150122074458.GL22024@x1>
Message-ID: <CAKXHbyOhD5_cHRp02AuhcYFR5m8nBvWzdsygUdw689LrS9R67g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-22 8:44 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
>
> Are you sure a struct is required at all now?  It only contains a
> single bool after all.


Hi Lee

Okay, I will gladly remove ab8500_ext_regulator_cfg completely.
And I will try to update the comments, but since I'm not so familiar
with what this code was meant to do it is a little more difficult.

Kind regards
Rickard Strandqvist
