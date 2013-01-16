From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Jan 2013 10:30:35 -0700
Subject: [PATCH v4 5/9] ARM: Tegra: Define Tegra30 CAR binding
In-Reply-To: <20130116132856.2896df94f553f78273c4574c@nvidia.com>
References: <1357890387-23245-1-git-send-email-pgaikwad@nvidia.com>
 <1357890387-23245-6-git-send-email-pgaikwad@nvidia.com>
 <20130116132856.2896df94f553f78273c4574c@nvidia.com>
Message-ID: <50F6E3BB.5060007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 04:28 AM, Hiroshi Doyu wrote:
> On Fri, 11 Jan 2013 08:46:23 +0100
> Prashant Gaikwad <pgaikwad@nvidia.com> wrote:
> 
>> The device tree binding models Tegra30 CAR (Clock And Reset)
>> as a single monolithic clock provider.

>> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt

>> +Example board file:
>> +
>> +/ {
>> +       clocks {
>> +               compatible = "simple-bug";
> 
> typo, 's/simple-bug/simple-bus/' ?

It was rather accurate though; a simple bug:-)

I've squashed the fix into the patch.
