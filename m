From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Jan 2015 17:04:09 +0530
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150129110744.GU21293@sirena.org.uk>
References: <CAKohpokxdpF2nTeOnDpofNM1vW3aZRyDBE3WKmvZ8wJedf-TGw@mail.gmail.com>
 <20150129110744.GU21293@sirena.org.uk>
Message-ID: <CAKohpomqR77p0PKXCC+VbxtwWG+BGGaMJ7r5NVXKt4XUP9=OAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2015 at 16:37, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jan 29, 2015 at 07:09:23AM +0530, Viresh Kumar wrote:

>> The goal is to choose the driver which we want to probe for a platform. There
>> can be multiple DT enabled cpufreq drivers present in a build and the platform
>> needs some way to choose one of them.
>
> So you need to document this as a platform device then if that's what
> you're doing here; there's more than just specifying a compatible string
> involved.

Will elaborate more on this to make it crystal clear..
